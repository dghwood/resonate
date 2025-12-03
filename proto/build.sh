# --go_out=$HOME/cs/resonate/server \
# --go_opt=paths=source_relative \
echo $HOME;

protoc \
--proto_path=$PWD/../ \
--dart_out=$PWD/../app/lib/ \
--go_out=$PWD/../server \
--go_opt=paths=source_relative \
--go_opt=default_api_level=API_HYBRID \
$PWD/../proto/*.proto
echo 'built'