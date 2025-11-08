# --go_out=$HOME/cs/resonate/server \
# --go_opt=paths=source_relative \
echo $HOME;

protoc \
--proto_path=$HOME/Code/resonate \
--dart_out=$HOME/Code/resonate/app/lib/ \
--go_out=$HOME/Code/resonate/server \
--go_opt=paths=source_relative \
--go_opt=default_api_level=API_HYBRID \
$HOME/Code/resonate/proto/*.proto 
echo 'built'