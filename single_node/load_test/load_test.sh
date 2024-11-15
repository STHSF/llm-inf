# 压测命令
# ab -n 1000 -c 40 -k -r -s 10000 -T "application/json" -H "Content-Type: application/json"  -p /home/liyu/workshop/LLM/llm-inf/single_node/load_test/request_data_short.json "http://192.168.11.37:18091/v1/chat/completions"

# ab -n 1000 -c 5 -k -r -s 10000 -T "application/json" -H "Content-Type: application/json"  -p /home/liyu/workshop/LLM/llm-inf/single_node/load_test/request_data_mid.json "http://192.168.11.37:18091/v1/chat/completions"

ab -n 1000 -c 8 -k -r -s 10000 -T "application/json" -H "Content-Type: application/json"  -p /home/liyu/workshop/LLM/llm-inf/single_node/load_test/request_data_long.json "http://192.168.11.37:18091/v1/chat/completions"
