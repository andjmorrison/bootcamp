Attribute VB_Name = "stock_data_moderate"

Sub stock_moderate()


'dim variables/define

'define ticker
Dim ticker As String
'yearly change, start at 0
Dim yearly_change As Single
yearly_change = 0
'percent change, start at 0
Dim percent_change As Double
percent_change = 0
'stock volume, start at 0
Dim stock_volume As Variant
stock_volume = 0
'table row, start at row 2
Dim table_row As Long
table_row = 2

'--------------------

'format totals table
Cells(1, 9).Value = "Ticker"
Cells(1, 10).Value = "Yearly Change"
Cells(1, 11).Value = "Percent Change"
Cells(1, 12).Value = "Total Stock Volume"
Columns("I:L").AutoFit
Columns("K").NumberFormat = "00.00%"

'determine last row
Dim last_row As Variant
last_row = Cells(Rows.Count, "A").End(xlUp).Row

'--------------------

'for loop--all up to last row
For rw = 2 To last_row

    'define ticker rows/column
    row_ticker1 = Cells(rw, 1).Value
    row_ticker2 = Cells(rw + 1, 1).Value

    'define columns/values
    row_stock = Cells(rw, 7).Value
       
    'if the ticker is not the same
     If row_ticker1 <> row_ticker2 Then
        
        close_price = Cells(rw, 6).Value
                
        'calculate yearly change
        yearly_change = close_price - open_price
        
        'calculate yearly percent change
        'percent_change = yearly_change / open_price
        If open_price = 0 Then
            percent_change = (percent_change + 0)
            Else
                percent_change = (yearly_change / open_price)
        End If
              
        'add values to ongoing volume total
        stock_volume = stock_volume + row_stock
        
        'fill out table
        
        'put ticker in table
        Range("I" & table_row).Value = row_ticker1
        
        'put yearly change in table
        Range("J" & table_row).Value = yearly_change
        
        'conditional format yearly change values (4/green = positive, 3/red = negative)
        If yearly_change > 0 Then
            Range("J" & table_row).Interior.ColorIndex = 4
            Else
                Range("J" & table_row).Interior.ColorIndex = 3
        End If
        
        'reset yearly change value
        yearly_change = 0
                
        'put percent change in table and reset value
        Range("K" & table_row).Value = percent_change
        percent_change = 0
        
        'put final volume total in table and reset value
        Range("L" & table_row).Value = stock_volume
        stock_volume = 0
        
        'add to table row
        table_row = table_row + 1
        
        'set open price to next row
        open_price = Cells(rw + 1, 3).Value
                
    'if ticker is the same
    Else
    
        'add values to ongoing volume total
        stock_volume = stock_volume + row_stock
        
        'first row
        If table_row = 2 Then
            open_price = Cells(2, 3).Value
        End If
               
    End If
    
    
Next rw

End Sub
