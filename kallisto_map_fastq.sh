#!/bin/bash
# Copyright (c) 2019 Weston Berg
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# Check correct number of cmd line inputs
if [[ $# -ne 4 ]]; then
    echo "Incorrect number of parameters"
    echo "Supply parameter for indexed file, out dir, and pair of fasq files, respectively"
    exit 1
fi

# Check indexed file
if [ ! -f "$1" ]; then
    echo "Indexed file does not exist"
    exit 1
fi

# Check output directory
if [ ! -d "$2" ]; then
    echo "Unknown output directory"
    exit 1
fi

# Check pair of fastq files
if [[ ${3: -9} != ".fastq.gz" ]] || [[ ${4: -9} != ".fastq.gz" ]]; then
    echo "Fastq files must have extension .fastq.gz"
    exit 1
fi

# Create dir for accession number if needed
IFS='/' read -ra Split_Str <<< "$3"
temp=${Split_Str[-1]}
IFS='_' read -ra dir_name <<< "$temp"
combined_dir=""
if [[ ${2: -1} == "/" ]]; then
    combined_dir="$2""$dir_name"
else
    combined_dir="$2"/"$dir_name"
fi

if [ ! -d "$combined_dir" ]; then
    mkdir "$combined_dir"
fi

# Map pair of fastq files to the index genome
echo "Loading Kallisto"
module load kallisto

echo "Mapping fastq to indexed genome"
kallisto quant -i "$1" -o "$combined_dir" -t 16 "$3" "$4"
