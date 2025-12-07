WORKING_DIR=$HOME/Code/resonate
echo $WORKING_DIR;

protoc \
--proto_path=$WORKING_DIR \
--dart_out=$WORKING_DIR/app/lib/ \
--go_out=$WORKING_DIR/server \
--go_opt=paths=source_relative \
--go_opt=default_api_level=API_HYBRID \
$WORKING_DIR/proto/*.proto 
echo 'built'