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
if [[ $# -ne 2 ]]; then
    echo "Incorrect number of parameters"
    echo "Supply parameter for input file and out file, respectively"
    exit 1
fi

# Second cmd line input is input file
if [[ ! -f $1 ]]; then
    echo "Input file not found"
    exit 1
fi

# Check input file extension
if [[ ${1: -3} != ".fa" ]]; then
    echo "Input file type must be fasta (.fa)"
    exit 1
fi

# Load Kallisto
echo "Loading kallisto..."
module load kallisto

# Create index
echo "Creating index..."
kallisto index -i "$2" "$1"

