//+------------------------------------------------------------------+
//|                                                 AverageRange.mq4 |
//|                                                     David Dvorak |
//|                                       https://github.com/reddawe |
//+------------------------------------------------------------------+
#property copyright "David Dvorak"
#property link      "https://github.com/reddawe"
#property version   "1.00"
#property strict
#property indicator_separate_window

extern double period=14;

double ARBuffer[];
double sum = 0;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping
   SetIndexBuffer(0,ARBuffer);
   SetIndexStyle(0,DRAW_LINE,STYLE_SOLID,1, clrYellow);
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
//---
   for (int i=0; i < Bars-period-1; i++){
      sum = 0;
      for (int j=0; j < period; j++) {
         sum = sum + MathAbs(Close[j+i] - Close[j+1+i]);
      }
      ARBuffer[i]=sum/period;
   }
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
