set terminal pngcairo size 1920,1080
set output 'proper-time-one-light-year.png'

c = 1079252849.0

f(v) = sqrt(1.0 - (v/c)**2) / (v/c) * 365.25

set title "Proper Time to Traverse 1 Light Year"
set xlabel "Velocity (km/h)"
set ylabel "Proper Time (days)"

set xrange [10000:c]
set logscale x
set logscale y

set grid
set key off

set samples 1000000

plot f(x) with lines lw 2
