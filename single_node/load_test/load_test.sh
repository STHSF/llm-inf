# 压测命令
host="192.168.11.37"
port="18091"

# ab -n 1000 -c 40 -k -r -s 10000 -T "application/json" -H "Content-Type: application/json"  -p /home/liyu/workshop/LLM/llm-inf/single_node/load_test/request_data_short.json "http://${host}:${port}/v1/chat/completions"

# ab -n 1000 -c 5 -k -r -s 10000 -T "application/json" -H "Content-Type: application/json"  -p /home/liyu/workshop/LLM/llm-inf/single_node/load_test/request_data_mid.json "http://${host}:${port}/v1/chat/completions"

ab -n 1000 -c 8 -k -r -s 10000 -T "application/json" -H "Content-Type: application/json"  -p /home/liyu/workshop/LLM/llm-inf/single_node/load_test/request_data_long.json "http://${host}:${port}/v1/chat/completions"
