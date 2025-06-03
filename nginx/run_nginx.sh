docker run -d \
-p 18099:80 \
--name nginx_llm \
-v /home/liyu/workshop/LLM/llm-inf/nginx/html:/usr/share/nginx/html \
-v /home/liyu/workshop/LLM/llm-inf/nginx/logs:/var/log/nginx \
-v /home/liyu/workshop/LLM/llm-inf/nginx/conf:/etc/nginx \
nginx
