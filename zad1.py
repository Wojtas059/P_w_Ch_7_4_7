import time
import redis
from datetime import datetime
import  pytz
from flask import Flask

app = Flask(__name__)
cache = redis.Redis(host='redis', port=6379)


@app.route('/')
def hello():
    
    now = datetime.now(pytz.timezone('US/Eastern'))
    print_time = "<h1> Hellow world!</h1> <br> <h3>Time in:</h3> <br> <tl> New York : "+str(now.strftime("%H:%M:%S"))+" "+str(now.date())
    now = datetime.now(pytz.timezone('Australia/Sydney'))
    print_time = print_time + "<br> <tl> Sydney: "+str(now.strftime("%H:%M:%S"))+" "+str(now.date())
    now = datetime.now(pytz.timezone('Poland'))
    print_time = print_time + "<br> <tl> Lublin: "+str(now.strftime("%H:%M:%S"))+" "+str(now.date())
    return print_time
if __name__ == "__main__":
    app.run(host="0.0.0.0", debug=True)