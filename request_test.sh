curl http://192.168.11.37:8099/v1/chat/completions  -H "Content-Type: application/json" -d '{
   "model": "/data/model/Qwen2-7B-Chat",
   "messages": [
   {"role": "system", "content": "You are a helpful assistant."},
   {"role": "user", "content": "Tell me something about large language models."}
   ],
   "stream":"True"
   }'
