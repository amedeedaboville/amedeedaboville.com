---
layout: post-light-feature
title: Some Data Processing
category: articles
tags: [etl, ruby, curl, football, unix]
image:
  feature: soccer_stadium.jpg
published: true
---

This post is from my old blog. 
It's about a weekend project where I downloaded a bunch of football match data and did some light analysis of it.
I had further plans to use it for "Machine Learning" and try my hand at a prediction engine, but I didn't get that far.
Sadly, I couldn't get the pictures back. It's a great example of where I was 4 years ago and reminds me of the progress I've made.

Since it was written in 2011, when I was much younger and inexperienced,
and since I had to edit it to put it into markdown, I made a few modifications. Here goes:

Learning Machine Learning
--
I wanted to learn machine learning so I’m building this project: A prediction model for soccer games.
Betting on things is pretty big here in the UK, and so is soccer.
If I could teach a machine to do both, it might be useful and fun.

The first part is to get some data. Scraping is an indispensable skill when doing data science, so this was a good exercise.
 With a bit of searching, I found football-data.co.uk, which has data for England going back something like 19 years.
 There is data on other countries, but I’ll get to it later.

There are more than 80 .csv files on the england page, so I didn’t want to download them all by hand.
 To be fair, if I had limited myself to a single division,
it would have been almost painless and all the time I took to write the script was probably way more than if I had just done it by hand.
Scraping is a such a powerful skill though, I didn’t want to pass up an opportunity to learn something.

I first downloaded the england page with curl. Then I went looking for the links that contain football data, ie finish in .csv. They were all
stored in the same folder so I grepped for that

``` bash
curl http://www.football-data.co.uk/englandm.php >> englandpage.txt 
grep -o -E 'mmz4281\/.{0,11}' englandpage.txt >> englandurls.txt
```

This tells grep to look for mmz4281/ and return the 11 characters immediately following. It then pipes that to a text file called englandurls.txt
this gave me a long text file with lines like

```bash
mmz4281/1011/E1.csv
mmz4281/1011/E2.csv
```
I wanted to use 

```bash
wget -i properurls.txt -w 5 --random-wait
```

which would download all of the files with a 5 second average wait. But it wouldn't mirror the folder structure and 

```bash
http://www.football-data.co.uk/mmz4281/9596/E1.csv
http://www.football-data.co.uk/mmz4281/9495/E1.csv
```

would be stored these two files as E1.csv and E1.csv.2, which doesn’t help at all.

EDIT: Wget has an option to mirror the local directories but I didn't know about it at the time
Also didn't know about wget's --base-url flag.

This is my little script to rebuild the folder hierarchy:

```bash
#!/bin/bash
for i in `cat $1`
do
folder=${i:39:4};
if [ ! -d $folder ]; then
echo "Folder $folder does not exist, creating it."
mkdir "$folder"
fi
endfile=$folder${i: (-7)}
if [ ! -f $endfile ]; then
`wget ${i} -O $endfile`;
sleep 5;
else
echo "File $endfile already exists."
fi
done
```
This script makes a lot of assumptions about the file name lengths, but they work here so that is all that matters.
They will need tweaking for the other countries, which have different names, but a regex that matches the last ‘/’ to the end of the string won’t be too hard to implement.

EDIT: I was just learning regexp. This is now really easy to me.

I now have all of England’s results. The next part will be analyzing the data for some obvious correlations.
First, I’ll look at the home advantage.
These data sets also have the odds of some bookies, I’d like to score them with a log-scoring rule and compare them.
Then I’d like to make a simple model.
Given how easy this is, all the available data columns have probably been mined for this.
Ideally I would add data to my model in the form of maybe weather conditions and other bookmakers’ odds.

Part 2
--

Most of my data from part 1 ended up corrupted so I wrote a script that would automate the process I went through in part 1.
It saves files in a simpler structure and can download a whole country’s files from football-data.co.uk.

```bash
#!/bin/bash
 
#fullscrape.sh: will download all of a country's files on football-data.co.uk
#input: the name of the country. It will use curl http://www.football-data.co.uk/COUNTRYNAMEm.php >>
#COUNTRYpage.txt to get i, find the listed files and download them at intervals, so as not to clobber the #site
#the files will be stored in a folder named COUNTRY as Division_year.csv
if [ $# -ne 1 ] then
    echo "Need a country name."
    exit 1
else
    echo "Scraping $1's data."
fi
 
if [ ! -f "$1page.txt" ] then
    echo "Downloading the links page."
    curl "http://www.football-data.co.uk/$1m.php" &gt;&gt; "$1page.txt";
else
    echo "$1page.txt exists already."
fi
 
if [ ! -d "$1" ] then
    mkdir "$1"
fi
 
if [ ! -d "$1/data" ] then
    mkdir "$1/data"
else
    echo "$1/data already exists."
fi
 
for i in `grep -o -E 'mmz4281\/.{0,11}' "$1page.txt"`
    do
    if [ ${i:8:1} == "9" ] then
        prefix="19"
    else
        prefix="20"
    fi

    file="${i:13:2}$prefix${i:8:2}.csv";
    wget  http://www.football-data.co.uk/${i} -O $1/data/$file;
    sleep 3s;
done
```

Note: it doesn’t work for countries like spain and scotland, because the website stores the country name in two characters: SC and SP instead
of E1 or F3. I assume the first two characters are the country name and the division number.
This can be fixed by a regex that matches the first number in the string, but I don’t need it yet.

EDIT: Again, I was really bad at regex.

if [ $# -ne 1 ] checks if there is one argument provided (the country name). It then downloads the page if needed, and the 
next two if statements check for the folders country/data and create them if needed.

While I was working with the data I actually had some Y2K problems because the years are two digits long.
Here I fix it by adding 19 in front of the year if the first digit is a 9.

The files then get downloaded to data/E01994.csv, data/E32006.csv, etc.
This way I can run a simple script on all files E1* and get get all of them in one division.
While bash scripting, I strongly suggest using ECHO to output any command you want run before putting the backticks in, so you can see what commands the script will run.
That has saved my files several times over.

I was going to do this analyis in Julia; a new data-science oriented language I had heard about, so I went ahead and installed it.
I was about to start when I realized Julia is so new it doesn’t even have much in the way of visualization tools!

I then tried this in R, but it didn’t like things that weren’t numbers (like “A” signifying that the away team had won the game) and I realized I didn't really need R.
I then moved to ruby, and I got everything to work very easily!

Edit: man, back in the day, Julia was really young. And I was weak at R.

```ruby
#!/usr/bin/ruby
 
#homeadvantage.rb
#by Amedee d'Aboville
#reads in the csv file and counts the number of draws, home and away wins. Outputs them to the screen.
 
require 'csv'
#nice snippet I got from 
#<a href="http://snippets.dzone.com/posts/show/3899">here</a> changes the CSV into an array of hashes
raw = CSV.read( ARGV[0])
headers = raw.shift.map {|i| i.to_s }
string_data = raw.map {|row| row.map {|cell| cell.to_s } }
hashes = string_data.map {|row| Hash[*headers.zip(row).flatten] }
 
#the only features I care about so far
features = Hash["A" =>0, "H"=>0, "D"=>0]
 
hashes.each do |game|
features[game["FTR"]] +=1 if(game["FTR"] !="") #checks for an empty value
end
 
puts "#{ARGV[0][-8..-5]},#{features["H"]},#{features["A"]},#{features["D"]}"
#outputs the year, home wins, away wins, draws
```

So far I only run the ruby code on one file at at time, and use a bash script to iterate through the files.
In the future I will probably have ruby count up a whole division at a time.
Well, not a whole division, because I will want a training set and a test set.

The bash will run this on all of the E0 files and output to a file named E0.csv, which I’ll put into excel to chart.
Later ruby will do the plots, now I just want some quick graphs.

I ran everything by doing

```bash
$for i in `ls data/E1*`; do ./homeadvantage.rb $i >> E1.csv; done
```
Pictures (based on England Premier League)


Time dependence of the home advantage

EDIT: The picture is missing here. Basically the home advantage was at a steady %20 IIRC with a few fluctations.


You can see it is much, much more likely for the home team to win.

Apparently there are “large fluctuations in the home advantage” (Pollard, 2008) but from (Koyama, Reade 2008)
it seems that the advantage decreased significantly in the mid 80s (due to increased match broadcasting on television, they argue) and hasn’t varied much. 
From my tiny dataset of the last 19 years, I don’t really see a change.

EDIT: This was a histogram of the fraction of wins I made using ggplot.

Probability plot of the difference between home wins and away wins.

Histogram of the home advantage, measured as the difference between % of home wins and % of away wins.
In blue, a kernel density estimate and a gaussian estimate in red.

The mean is 19.4%. This means, on average over the last nineteen years the home teams have won 19.4% more games than away teams.
On average, home teams have won 46.4% of games and away teams 26.9%. The difference is 19.4% with the extra rounding.

Test of Normality
EDIT: I had just taken a class in stats and thought I was really smart about guessing the distribution. 

This thing looked pretty normally distributed to me. I tested this with the Jarque Bera test of normality, but it was not conclusive.
The kurtosis was 2.67, and skewness -0.52 (a normal distribution has them at 3 and 0)
