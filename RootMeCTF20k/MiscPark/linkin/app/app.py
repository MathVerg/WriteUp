from flask import Flask, render_template, flash, request, send_from_directory, after_this_request, abort
import tempfile
import subprocess
import shutil
import os
import secrets

app = Flask(__name__)
# Max upload size in Bytes
app.secret_key = secrets.token_urlsafe(32)
app.config["MAX_CONTENT_LENGTH"] = 1024 * 1024  # 1MiB

INPUT_NAME = "main.o"
OUTPUT_NAME = "main"

@app.route("/")
def index(folder=None):
    return render_template("index.html", folder=folder)

@app.route('/upload', methods=['POST'])
def upload_file():
    # check if the post request has the file part
    if 'file' not in request.files:
        flash('No file provided!')
        return index()

    f = request.files['file']
    # If the user does not select a file, the browser submits an
    # empty file without a filename.
    if f.filename == '':
        flash('No file selected!')
        return index()

    folder = tempfile.mkdtemp(suffix=secrets.token_urlsafe(32))
    input_path = folder + "/" + INPUT_NAME
    f.save(input_path)
    output_path = folder + "/" + OUTPUT_NAME

    res = subprocess.run(["/usr/bin/gcc", "-fuse-ld=bfd", "-Wl,--fatal-warnings", input_path, "-o", output_path])
    if res.returncode !=0:
        flash("Error while linking the file")
        shutil.rmtree(folder, ignore_errors=True)
        return index()
    
    folder_relative = folder.split("/")[-1]

    return index(folder_relative)

@app.route('/download/<folder>', methods=['GET'])
def download_file(folder):
    folder_full = "/tmp/" + folder

    if not os.path.exists(folder_full + "/" + OUTPUT_NAME):
        abort(404)


    @after_this_request
    def remove_folder(response):
        shutil.rmtree(folder_full, ignore_errors=True)
        return response


    return send_from_directory("/tmp", folder + "/" + OUTPUT_NAME, download_name=OUTPUT_NAME, as_attachment=True)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=1337)