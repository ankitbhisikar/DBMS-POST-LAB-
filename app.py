import os
import webbrowser
from flask import Flask, jsonify, request, send_from_directory
from flask_cors import CORS

app = Flask(__name__, static_folder='.', static_url_path='')
CORS(app)

# Path to the SQL schema file (assumes it's in the same folder)
SCHEMA_PATH = os.path.join(os.path.dirname(__file__), 'schema.sql')

@app.route('/')
def home():
    return send_from_directory('.', 'index.html')

@app.route('/api/get-schema', methods=['GET'])
def get_schema():
    try:
        if not os.path.exists(SCHEMA_PATH):
            return jsonify({'success': False, 'error': 'schema.sql not found'}), 404
        with open(SCHEMA_PATH, 'r', encoding='utf-8') as f:
            schema = f.read()
        return jsonify({'success': True, 'schema': schema})
    except Exception as e:
        return jsonify({'success': False, 'error': str(e)}), 500

@app.route('/api/persist', methods=['POST'])
def persist():
    try:
        data = request.get_json()
        sql_command = data.get('sql')
        if not sql_command:
            return jsonify({'success': False, 'error': 'No SQL provided'}), 400

        # Append the SQL command to the schema file
        with open(SCHEMA_PATH, 'a', encoding='utf-8') as f:
            f.write(f"\n-- Persisted at runtime\n{sql_command};\n")
        print(f"✅ Persisted: {sql_command[:50]}...")
        return jsonify({'success': True})
    except Exception as e:
        return jsonify({'success': False, 'error': str(e)}), 500

if __name__ == '__main__':
    print("\n🚀 Starting QueryAcademy Server...")
    print(f"📁 Schema file: {os.path.abspath(SCHEMA_PATH)}")
    print("🌐 Open http://localhost:5500 in your browser")
    webbrowser.open('http://localhost:5500')
    app.run(debug=True, port=5500)