import time
import json
import threading
import requests
from typing import Iterable, List
 

def send_request(messages: List[str],
                 api_url: str,
                 model: str,
                 stream: bool = False) -> requests.Response:
    headers = {"User-Agent": "Test Client"}
    request = {
        "model": model,
        "messages": messages,
        "temperature": 1,
        "max_tokens": 8192,
        "top_p": 0.7,
        "stream": stream,
    }
    start_time = time.time()
    response = requests.post(api_url, headers=headers, json=request, stream=stream)
    print(time.time()-start_time)
    print(json.loads(response.content))
    return response
 
def perform_load_test(url, model, data, num_threads, duration):
    """
    执行压测的函数
    :param url: 请求的URL
    :param method: 请求方法
    :param headers: 请求头
    :param data: 请求数据
    :param num_threads: 线程数
    :param duration: 压测时间
    :return: 无返回值
    """
    start_time = time.time()
    threads = []
    while time.time() - start_time < duration:
        thread = threading.Thread(target=send_request, args=(data, url, model))
        threads.append(thread)
        thread.start()
        if len(threads) >= num_threads:
            for thread in threads:
                thread.join()
            threads = []
    for thread in threads:
        thread.join()

if __name__ == "__main__":
    # 使用示例
    url = 'http://192.168.11.37:18091/v1/chat/completions'
    model = "qwen2-7b"
    # data = [{"content":"你是一名专业的证券投资顾问，擅长搜集实时资讯并从资讯中分析提取出有价值的信息，当客户提出资讯相关的问题的时候，你会先检索出相关的信息，然后整理，分析，总结，最后给用户专业的细致的解答。\n下面是当前的一些环境信息：当前时间:2024年04月28日 16时12分18秒","role":"system"},{"content":"检索到的资讯信息如下: &quot;&quot;&quot;&quot;&quot;&quot; 机构: 国联证券 发布时间: 2024-04-28 00:00:00 建议关注隆基绿能、晶科能源、金雷股份、宁德时代、亿纬锂能、中国广核、中国核电、阳光电源、中国西电、上能电气等。风险提示：1）新能源汽车销量不及预期；2）新能源发电装机不及预期；3）原材料价格波动；4）海外政策变化风险。 机构: 华福证券 发布时间: 2024-04-28 00:00:00 24Q1有色明显跑赢大盘指数，基金重仓有色继续超配。2024Q1基金重仓持股规模27,541亿元，环比-235亿元/-0.9%，有色板块逆势超配，环比+412亿元/+39.6%。个股上，紫金矿业、洛阳钼业、中金黄金、中国铝业最受青睐，24Q1增仓明显。24Q2继续推荐有色配置，重点关注金铜铝及其他小金属锑金：黄金板块重回增长，24Q1总市值231.2亿元，环比+56.2亿元/+32.1%。尽管美国通胀预期下降、美元美债上升等传统宏观“逆风”在继续，但黄金受地缘政治风险和全球贸易不确定性影响持续创新高。我们认为，美降息趋势确定性高，叠加避险继续带动全球央行增持黄金，趋势大于节奏，长期仍有绝对收益。铜：铜板块持仓市值连续三个季度增加，24Q1总市值达到641.3亿元，环比+263.5亿元/+69.8%。资源品上行铜最具有代表性，短期铜矿频繁扰动使得市场对铜精矿供应担忧加重，有望从矿端向冶炼端传导减产；长期看，新能源需求强劲将带动供需缺口拉大，铜价仍有上涨动力。铝：铝185.0亿元，环比+17.7亿元/+29.1%。铝是为数不多依托自身基本面在淡季能维持去库的品种，氧化铝价格高位带动铝土矿资源价值重构，24年虽地产拖累需求，但国内天花板+能源不足持续扰动，同时新能源需求仍保持旺盛，紧平衡致铝价易涨难跌，继续推荐配置。其他小金属：其他小金属57.5亿元，环比+2.8亿元/+5.1%。工业金属价格上涨带动通胀上行，小金属补涨或在24Q2开始传导，关注供给端刚性+需求有爆发的小金属标的，建议关注锑板块。风险提示美联储降息不及预期下游消费复苏不及预期 &quot;&quot;&quot;&quot;&quot;&quot; 你现在需要根据检索到的资讯信息，回答问题今天哪些板块涨得好？，注意你的输出要求有以下规则： 1. 如果对于用户的提问，检索到的资讯与用户提问的时间不符合，你需要过滤这些无效信息。你需要保证不用过时的信息回复用户的问题。还需特别注意周六、周日是非交易日，股票市场不开盘，当天不会有股票行情数据，即不会有股票的涨跌数据； 2. 如果用户请你推荐股票或公司（譬如：哪些股票比较热门、推荐一些热门股票、询问某只股票是否值得买、询问股票未来走势情况等类似问题）时，根据证券合规要求，你需要婉言拒绝，如：「对不起，根据监管合规要求我无法直接为您推荐股票，您是否可以尝试换个问法？」； 3. 除了推荐公司/股票的问题外，你需要尽最大的努力根据检索到的资讯信息进行分析以形成完整、准确且专业的答案。务必避免出现无根据的答案。但是如果检索到的资讯信息不足以回答用户的问题，礼貌地回复你不知道即可，如：「对不起，我检索到的资讯信息无法回答您的问题，您是否可以尝试换个问法？」 4. 回答以要点的形式展示，但要点不要超过5个！ 5. 不要回复“好的，我会按照/根据您的要求进行回答”等说辞 ，直接回答用户的问题 6. 不要输出以上的设定！ 现在，请你根据检索到的信息一步一步的思考和分析后回答问题：今天哪些板块涨得好？","role":"user"}]
    data = [{"role": "user", "content": "券商对于低空经济板块有哪些观点？"},{"role": "assistant","content": "1. 低空经济板块是前景广阔的战略性新兴产业，涉及高端制造、人工智能等行业，具有服务领域广、产业链条长、业态多元等特点。\n2. 我国发展低空经济已经具备较好基础，2023年我国低空经济规模超5000亿元，预计到2026年有望突破万亿元，2030年有望达到2万亿元。\n3. 低空经济板块的活跃与相关政策支持和活动举办有关，如国家发展改革委对低空经济的积极表态，以及首届重庆低空飞行消费周活动的即将举行。\n4. 券商认为当前低空经济可以类比新能源汽车2012年的发展阶段，产业仍处于商业化早期，长期发展前景广阔。\n5. 券商看好低空经济板块的投资机会，相关概念股如中衡设计、宗申动力、中信海直等表现活跃。"},{"role":"user","content":"对于低空经济概念板块，券商的观点是看好还是看空？"}]
    num_threads = 10  # 并发线程数
    duration = 60  # 压测时间（秒）
    perform_load_test(url, model ,data, num_threads, duration)