from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello_world():
    return '''
    <html>
        <head>
            <title>DevOps Lab - Usman</title>
            <style>
                body {
                    font-family: Arial, sans-serif;
                    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                    color: white;
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    height: 100vh;
                    margin: 0;
                }
                .container {
                    text-align: center;
                    background: rgba(255, 255, 255, 0.1);
                    padding: 50px;
                    border-radius: 20px;
                    box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
                }
                h1 {
                    font-size: 3em;
                    margin-bottom: 20px;
                }
                p {
                    font-size: 1.5em;
                }
                .badge {
                    background: #4CAF50;
                    padding: 10px 20px;
                    border-radius: 25px;
                    margin-top: 20px;
                    display: inline-block;
                }
                .version {
                    margin-top: 20px;
                    font-size: 0.9em;
                    opacity: 0.8;
                }
            </style>
        </head>
        <body>
            <div class="container">
                <h1>Hellooooooo</h1>
                <p>Created by Usman - Full Stack DevOps Engineer</p>
                <p style="font-size: 1.2em; margin-top: 10px;">🔄 Automated CI/CD with GitHub Actions</p>
                <div class="badge">✅ Pipeline Active & Running</div>
                <div class="version">Version 1.3 - Live on AWS EC2 🌐</div>
            </div>
        </body>
    </html>
    '''

@app.route('/health')
def health():
    return {'status': 'healthy'}, 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
