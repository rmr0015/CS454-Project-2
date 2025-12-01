import flask
import psycopg2

app = flask.Flask(__name__)
@app.route("/")

def debugprint():
    conn = psycopg2.connect("dbname='ubuntu' user='ubuntu' host='postgres' password='DEMO1'")
    conn.close()
    return "Test"

app.run(host="0.0.0.0", port=5000)
