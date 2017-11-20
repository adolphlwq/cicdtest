from flask import Flask
from flask import jsonify

app = Flask(__name__)

@app.route("/")
def index():
    return "hello world"

@app.route('/health')
def health():
    return jsonify(status="health")

@app.route('/_ping')
def ping():
    return jsonify("pong")

@app.route('/_diagnose')
def diagnose():
    return jsonify({"status":"OK"})

@app.route('/status')
def status():
    return jsonify(hello="world")

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
