# --go_out=$HOME/cs/resonate/server \
# --go_opt=paths=source_relative \
echo $PWD;

protoc \
--proto_path=. \
--dart_out=app/lib/ \
--go_out=server \
--go_opt=paths=source_relative \
--go_opt=default_api_level=API_HYBRID \
proto/*.proto
echo 'built'