from flask import Flask, request, jsonify
import subprocess

app = Flask(__name__)

@app.route('/execute', methods=['POST'])
def execute():
    data = request.get_json()
    command = data.get('command')

    if not command:
        return jsonify({'error': 'No command provided'}), 400

    try:
        # Execute the command in the terminal
        result = subprocess.check_output(command, shell=True, stderr=subprocess.STDOUT, text=True)
        return jsonify({'output': result})
    except subprocess.CalledProcessError as e:
        return jsonify({'output': e.output, 'error': str(e)}), 400

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
