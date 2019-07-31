#!/bin/bash
# Copyright (c) 2019 Weston Berg
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

if [[ $# -eq 0 ]]; then
    echo "No filename supplied"
    exit 1
fi

if [[ ! -f $1 ]]; then
    echo "File not found!"
    exit 1
fi

if [[ ${1: -4} != ".sra" ]]; then
    echo "File extension must be .sra"
    exit 1
fi

module load sra-toolkit

echo "Converting $1 to fastq format..."
fastq-dump --outdir ./fastq_files --split-files --origfmt --gzip "$filename"

