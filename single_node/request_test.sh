curl http://192.168.11.37:8091/v1/chat/completions  -H "Content-Type: application/json" -d '{
   "model": "qwen2-7b",
   "messages": [
   {"role": "system", "content": "You are a helpful assistant."},
   {"role": "user", "content": "Tell me something about large language models."}
   ],
   "stream":"True"
   }'
