from flask import Flask
from flask import jsonify

app = Flask(__name__)

@app.route("/")
def index():
    return "hello world"

@app.route('/health')
def health():
    return jsonify(status="health")

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
