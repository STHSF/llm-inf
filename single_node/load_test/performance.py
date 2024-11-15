import re
import time
import requests


url = 'http://192.168.11.37:18091/metrics'

response = requests.get(url)    # GET request to the URL

for i in range(0, 10000000):
    time.sleep(1)    # Sleep for 1 second
    response = requests.get(url)
    if response.status_code == 200:
        # Extracting the values of the metrics from the response
        ## time_to_first_token_seconds
        time_to_first_token_seconds_sum = re.search(r'vllm:time_to_first_token_seconds_sum{model_name="qwen2-7b"} (\d+\.\d+)', response.text)
        time_to_first_token_seconds_sum_value = float(time_to_first_token_seconds_sum.group(1))
        time_to_first_token_seconds_count = re.search(r'vllm:time_to_first_token_seconds_count{model_name="qwen2-7b"} (\d+)', response.text)
        time_to_first_token_seconds_count_value = int(time_to_first_token_seconds_count.group(1))
        time_to_first_token_seconds_avg = time_to_first_token_seconds_sum_value / time_to_first_token_seconds_count_value

        ## request_prompt_tokens
        request_prompt_tokens_sum = re.search(r'vllm:request_prompt_tokens_sum{model_name="qwen2-7b"} ([+-]?(?:\d+\.\d+|\d+\.|\.\d+)(?:[eE][+-]?\d+)?)', response.text)
        # request_prompt_tokens_sum = re.search(r'vllm:request_prompt_tokens_sum{model_name="qwen2-7b"} (\d+(?:\.\d+)?e[+-]?\d+)', response.text)
        request_prompt_tokens_sum_value = float(request_prompt_tokens_sum.group(1))
        request_prompt_tokens_count = re.search(r'vllm:request_prompt_tokens_count{model_name="qwen2-7b"} (\d+)', response.text)
        request_prompt_tokens_count_value = int(request_prompt_tokens_count.group(1))

        request_prompt_tokens_avg = request_prompt_tokens_sum_value / request_prompt_tokens_count_value

        ## request_generation_tokens
        request_generation_tokens_sum = re.search(r'vllm:request_generation_tokens_sum{model_name="qwen2-7b"} ([+-]?(?:\d+\.\d+|\d+\.|\.\d+)(?:[eE][+-]?\d+)?)', response.text)
        request_generation_tokens_sum_value = float(request_generation_tokens_sum.group(1))
        request_generation_tokens_count = re.search(r'vllm:request_generation_tokens_count{model_name="qwen2-7b"} (\d+)', response.text)
        request_generation_tokens_count_value = int(request_generation_tokens_count.group(1))
        request_generation_tokens_avg = request_generation_tokens_sum_value / request_generation_tokens_count_value

        ## request_total_tokens
        e2e_request_latency_seconds_sum = re.search(r'vllm:e2e_request_latency_seconds_sum{model_name="qwen2-7b"} (\d+\.\d+)', response.text)   
        e2e_request_latency_seconds_sum_value = float(e2e_request_latency_seconds_sum.group(1))
        e2e_request_latency_seconds_count = re.search(r'vllm:e2e_request_latency_seconds_count{model_name="qwen2-7b"} (\d+)', response.text)
        e2e_request_latency_seconds_count_value = int(e2e_request_latency_seconds_count.group(1))
        e2e_request_latency_seconds_avg = e2e_request_latency_seconds_sum_value / e2e_request_latency_seconds_count_value


        print(r'time_to_first_token_seconds_avg: %s, request_prompt_tokens_avg: %s, request_generation_tokens_avg: %s, e2e_request_latency_seconds_avg: %s' %
               (time_to_first_token_seconds_avg, 
                request_prompt_tokens_avg, 
                request_generation_tokens_avg, 
                e2e_request_latency_seconds_avg
                ))
    else:
        print('Error: Status code is not 200')
        print('Trying again...')
        continue