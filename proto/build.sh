# --go_out=$HOME/cs/resonate/server \
# --go_opt=paths=source_relative \
echo $HOME;
protoc \
--proto_path=$HOME/cs/resonate/ \
--dart_out=$HOME/cs/resonate/app/lib/ \
$HOME/cs/resonate/proto/*.proto 
echo 'built'