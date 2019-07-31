#!/bin/bash
# Copyright (c) 2019 Weston Berg
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# Check input directory
if [ ! -d "$1" ]; then
    echo "Unknown directory"
    exit 1
fi

# Get name for outdir from command line
IFS='/' read -ra dir_name <<< "$1"
outdir="./fastq_files/""${dir_name[-1]}""/"

# Create directory if necessary
if [ ! -d "$outdir" ]; then
    mkdir "$outdir"
fi

# Convert sra files
module load sra-toolkit

# Normalize input directory name
indir="$1"
if [[ ${indir: -1} != "/" ]]; then
    indir="$1""/"
fi

for filename in "$indir"*.sra; do
    [ -e "$filename" ] || continue
    echo "Converting $filename to fastq format..."
    fastq-dump --outdir "$outdir" --split-files --origfmt --gzip "$filename"
done
