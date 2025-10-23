class SVGCoord {
    constructor(x, y) {
        this.x = x;
        this.y = y;
    }

    add(coord) {
        this.x += coord.x;
        this.y += coord.y;
        return this;
    }
}

class SVGBoundingBox {
    constructor() {

    }

    topLeft = new SVGCoord(0, 0);
    bottomRight = new SVGCoord(0, 0);

    update(x, y) {
        console.log(x, y);
        if (this.topLeft.y > y) {
            this.topLeft.y = y;
        }
        if (this.topLeft.x > x) {
            this.topLeft.x = x;
        }

        if (y > this.bottomRight.y) {
            this.bottomRight.y = y;
        }
        if (x > this.bottomRight.x) {
            this.bottomRight.x = x;
        }
        console.log('boundingBox',
            this.topLeft.x, this.topLeft.y,
            this.bottomRight.x, this.bottomRight.y);
    }

    width() {
        return this.bottomRight.x - this.topLeft.x;
    }

    height() {
        return this.bottomRight.y - this.topLeft.y;
    }

    center() {
        return new SVGCoord(this.width() / 2, this.height() / 2);
    }

    ccenter() {
        return this.center()
            .add(this.topLeft);
    }

}
class SVGElement {

    constructor(doc, tag) {
        var element = this.#createElement(doc, tag);
        this.id = crypto.randomUUID();
        element.id = this.id;

        element.setAttribute('stroke', 'black');
        element.setAttribute('fill', 'transparent');
        this.element = this.#createElement(doc, 'use');
        this.element.setAttribute('href', '#' + this.id);
        this.def = element;
        this.boundingBox = new SVGBoundingBox();
    }



    // boundingBox = new SVGBoundingBox();
    x = 0;
    y = 0;

    transform = [];

    #createElement(doc, tag) {
        return doc.createElementNS('http://www.w3.org/2000/svg', tag);
    }
    updateBoundingBox(dx, dy) {
        this.x += dx;
        this.y += dy;
        this.boundingBox.update(this.x, this.y);
    }
    setTransform() {
        console.log(this.transform);
        this.element.setAttribute('transform', this.transform.join(' '));
    }
    translate(dx, dy) {
        this.element.setAttribute('x', dx);
        this.element.setAttribute('y', dy);
        return this;
    }
    ctranslate(dx, dy) {
        var center = this.boundingBox.ccenter();

        this.element.setAttribute('x', dx - center.x);
        this.element.setAttribute('y', dy - center.y);
        return this;
    }
    rotate(degrees) {
        // this assumes 0,0 cord
        // if a translate happens
        var center = this.boundingBox.ccenter();
        console.log('center', center);
        this.transform.push(`rotate(${degrees}, ${center.x}, ${center.y})`);
        this.setTransform();
        return this;
    }
}

class SVGRect extends SVGElement {
    constructor(doc) {
        super(doc, 'rect');
    }
    attr = {
        x: 0,
        y: 0,
        width: 0,
        height: 0
    }

    update() {
        var element = this.def;
        element.setAttribute('x', this.attr.x);
        element.setAttribute('y', this.attr.y);
        element.setAttribute('width', this.attr.width);
        element.setAttribute('height', this.attr.height);
    }
    fromBoundingBox(boundingBox) {
        this.attr.x = boundingBox.topLeft.x;
        this.attr.y = boundingBox.topLeft.y;
        this.attr.width = boundingBox.width();
        this.attr.height = boundingBox.height();
        this.update();
        return this;
    }
}

class SVGPath extends SVGElement {
    path = [];

    constructor(doc) {
        super(doc, 'path');
    }

    setPath() {
        // console.log(this.path);
        this.def.setAttribute('d', this.path.join(' '));
        return this;
    }

    Move(x, y) {
        this.path.push(`M ${x} ${y}`);
        this.setPath();
        this.updateBoundingBox(x, y);
        return this;
    }
    move(x, y) {
        this.path.push(`m ${x} ${y}`);
        this.setPath();
        this.updateBoundingBox(x, y);

        return this;
    }
    line(x, y) {
        this.path.push(`l ${x} ${y}`);
        this.setPath();
        this.updateBoundingBox(x, y);
        return this;
    }
    hline(x) {
        return this.line(x, 0);
        this.updateBoundingBox(x, 0);
    }
    vline(y) {
        return this.line(0, y);
        this.updateBoundingBox(0, y);
    }
    curve(x0, y0, x1, y1, x2, y2) {
        this.path.push(`c ${x0} ${y0}, ${x1} ${y1}, ${x2} ${y2}`);
        this.setPath();
        this.updateBoundingBox(x2, y2);
        return this;
    }
    vsigmoid(x, y) {
        return this.curve(
            0, y / 2,
            x, y / 2,
            x, y);
    }
    hsigmoid(x, y) {
        return this.curve(
            x / 2, 0,
            x / 2, y,
            x, y);
    }
    arc(rx, ry, x, y, outer) {
        this.path.push(`a ${rx} ${ry} 0 0 ${outer ? 1 : 0} ${x} ${y}`);
        this.setPath();
        this.updateBoundingBox(x, y);
        return this;
    }
    rcorner(x, y, outer) {
        return this.arc(
            x, y,
            x, y,
            outer
        );
    }
    // Rounded Horizontal End
    // You end up at w 0
    rhend(w, r) {
        var sign = w >= 0 ? 1 : -1;
        r = r * sign;
        // if (w < 2 * r) {
        //   // width >= 2 * radius
        //   r = w/2;
        // }
        this.rcorner(r, r);
        this.hline(w - 2 * r);
        this.rcorner(r, -r);
        return this;
    }

    rvend(w, r) {
        var sign = w >= 0 ? 1 : -1;
        r = r * sign;
        // if (w < 2 * r) {
        //   // width >= 2 * radius
        //   r = w/2;
        // }
        this.rcorner(r, r, 1);
        this.vline(w - 2 * r);
        this.rcorner(-r, r, 1);
        return this;
    }


}

class SVGEditor {
    namespace = 'http://www.w3.org/2000/svg'
    constructor(doc, width, height) {
        this.doc = doc;
        var svg = doc.createElementNS(this.namespace, 'svg');
        var defs = doc.createElementNS(this.namespace, 'defs');
        this.defs = defs;
        svg.appendChild(defs);

        // svg.setAttribute('xmlns', "");
        svg.setAttribute('width', width);
        svg.setAttribute('height', height);
        svg.setAttribute('viewBox', `0 0 ${width} ${height}`);
        svg.setAttribute('fill', 'none');
        svg.setAttribute('style', `
            margin: 10px; 
            border: 1px solid black;     
        `);
        this.svg = svg;
        doc.body.appendChild(svg);
    };

    newPath() {
        var path = new SVGPath(this.doc);
        this.defs.appendChild(path.def);
        this.svg.appendChild(path.element);
        return path;
    }

    newRect() {
        var rect = new SVGRect(this.doc);
        this.defs.appendChild(rect.def);
        this.svg.appendChild(rect.element);
        return rect;
    }
}