install.packages('forecast', dependencies = TRUE)
library(forecast)
library(quantmod)   # to use getSymbols and get a dataset in real time from Yahoo! Finance
library(tidyquant)
library(timeSeries)
library(tseries)


#Dataset - Google
getSymbols('GOOGL', from = '2021-02-01', src='yahoo') 
View(GOOGL)
class(GOOGL)



open_price = GOOGL[,1]
high_price = GOOGL[,2]
low_price = GOOGL[,3]
close_price = GOOGL[,4]
volume_price = GOOGL[,5]
adjusted_price = GOOGL[,6]

plot(open_price)
plot(high_price)
plot(low_price)
plot(close_price)
plot(volume_price)
plot(adjusted_price)



#target / this is the variable that I will use to make the prediction
pred_close_price = GOOGL$GOOGL.Close



# a)	Check whether the time series is stationary in mean and variance. 
plot(pred_close_price)

### it is not stationary ###

s=diff(pred_close_price) #mean
plot(s)

ls=diff(log(pred_close_price)) #variance
plot(ls)




# b)	Use acf() and pacf() functions to identify the order of AR and MA. 
acf(s, na.action = na.pass)
q=1


pacf(ls, na.action = na.pass)
p=0





# c) Use auto.arima() to learn the best ARIMA model.

auto.fit = auto.arima(pred_close_price, seasonal=T) 
auto.fit

auto.fit = auto.arima(pred_close_price, seasonal=F)
auto.fit





# d) Forecast h=10 step ahead prediction of the time series variable and plot it with the original time series.                                                    
auto.fcast = forecast(auto.fit, h=10)
plot(auto.fcast)

