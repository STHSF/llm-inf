host="192.168.11.37"
port="18091"

# curl http://${host}:${port}/v1/chat/completions  -H "Content-Type: application/json" -d @request_data_short.json

# curl http://${host}:${port}/v1/chat/completions  -H "Content-Type: application/json" -d @request_data_mid.json

curl http://${host}:${port}/v1/chat/completions  -H "Content-Type: application/json" -d @request_data_long.json

