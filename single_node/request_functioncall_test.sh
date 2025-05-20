model="qwen3_8b"




curl http://192.168.11.37:18093/v1/chat/completions  -H "Content-Type: application/json" -d '{
   "model": "qwen3_8b",
   "messages": [
        {
            "role": "system",
            "content": "欢迎使用智能问答系统，我是您的助手，请问有什么可以帮助您的？"},
        {
            "role": "user", 
            "content": "券商对于低空经济板块有哪些观点？"},
        {
            "role": "assistant",
            "content": "1. 低空经济板块是前景广阔的战略性新兴产业，涉及高端制造、人工智能等行业，具有服务领域广、产业链条长、业态多元等特点。\n2. 我国发展低空经济已经具备较好基础，2023年我国低空经济规模超5000亿元，预计到2026年有望突破万亿元，2030年有望达到2万亿元。\n3. 低空经济板块的活跃与相关政策支持和活动举办有关，如国家发展改革委对低空经济的积极表态，以及首届重庆低空飞行消费周活动的即将举行。\n4. 券商认为当前低空经济可以类比新能源汽车2012年的发展阶段，产业仍处于商业化早期，长期发展前景广阔。\n5. 券商看好低空经济板块的投资机会，相关概念股如中衡设计、宗申动力、中信海直等表现活跃。"},
        {
            "role":"user",
            "content":"对于低空经济概念板块，券商的观点是看好还是看空？"}],
   "tools":tools,
   "stream":"False"
   }'


# 定义变量
URL="https://example.com"
HEADER="Authorization: Bearer YOUR_ACCESS_TOKEN"

# 使用变量
curl -X GET "$URL" -H "$HEADER"