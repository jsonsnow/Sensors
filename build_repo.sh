sed -n "/s.version          = '[0-9].[0-9].[0-9]'/p" $1
read -p "输入提交信息：" commit
read -p "输入tag号：" tag

echo "修改podspces的tag:  $tag"
sed -i '' -e "s/s.version          = '[0-9].[0-9].[0-9]'/s.version          = '$tag'/" $1
git add .
git commit -m $commit
git tag $tag
git push origin master
git push --tags

echo "正在推送到仓库"
pod repo push CLSpces $1 --allow-warnings --sources='https://github.com/jsonsnow/CLSpces.git,https://github.com/CocoaPods/Specs.git'
