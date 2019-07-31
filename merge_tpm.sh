#!/bin/bash
# Copyright (c) 2019 Weston Berg
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# Check parameter
if [[ $# -ne 1 ]]; then
    echo "Must supply directory to work in as param"
    exit 1
fi

if [ ! -d "$1" ]; then
    echo "Unknown working directory"
    exit 1
fi

# Change working directory
pushd "$1"

# Cut all .tsv files and merge the results
echo "Cutting tsv files..."
for D in */; do
    dir_name="${D::-1}"
    cut -f 1,5 "$D""abundance.tsv" > "$dir_name""_tpm"
done

echo "Merging files..."
awk '{arr[$1]=arr[$1]"\t"$2}END{for(i in arr)print i,arr[i]}' *_tpm > "salmonella_enterica_tpm_merged.tsv"

# Restore working directory
popd
