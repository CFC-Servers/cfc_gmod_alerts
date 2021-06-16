net.Receive "CFC_Alerts_Fancy", ->
    data = net.ReadTable
    chat.AddText unpack data
