cd /root
#wget https://github.com/STZZ-1992/douyin_analysis/releases/latest/download/douyin_analysis.tar.gz -O /root/douyin_analysis.tar.gz
mkdir /root/douyin_analysis
tar -zxvf douyin_analysis.tar.gz -C ./douyin_analysis
cd douyin_analysis
pip install -r requirements.txt
nohup python CODES/main.py &

exit 0