import tkinter as mytk
from tkinter import *
from tkinter import ttk
import pymssql 

#========================MAIN WINDOW=====================================

window = Tk()
window.geometry("500x500")
window.title("Sharon's Project")
icon = PhotoImage(file='dog.png')
window.iconphoto(True,icon)
window.config(background="#577075")

myLabel = Label(window,
                text="Sharon's Project",
                font=('Calibri',20,'bold'),
                fg="#000000",
                bg="#ada6a6",
                bd=3,
                relief=SUNKEN,
                padx=10,
                pady=20)

myLabel.grid(row=0,column=0,columnspan=2)
#===========================SP1==================================
def search_all_profits_by_store(StoreName):
    StoreName
    print (StoreName)
    newWindow = Toplevel(window)
    newWindow.title("All profits From Store - " + StoreName)
    newWindow.geometry("500x500")
    my_cmb.delete(0,END)
    conn = pymssql.connect(host='localhost', database='MovieRentalsDB')
    my_cursor3 = conn.cursor()
    my_cursor3.execute(f"execute [spDisplayAllProfitsByStore] '{StoreName}'")
   
    Label(newWindow, text="Profit From Store").grid(column=0,row=0)
    Label(newWindow, text="Location").grid(column=1,row=0)
    for i,my_current_row in enumerate (my_cursor3):
        for j,curr_col in enumerate (my_current_row):
            st1 = f'{curr_col}'
            print (st1)
            Label (newWindow, text=st1).grid(row=i+1,column=j)
    conn.close()
#==========================SP1-BTN+CMBX===================================

btn = Button(window,text="Search Store's Profit",
        command= lambda: search_all_profits_by_store(my_cmb.get())).grid(row=3, column=0,pady=20,padx=5,ipadx=10,ipady=10)

my_cmb = ttk.Combobox (window, width=30, textvariable=StringVar())
my_list = ['Wisconsin' , "New York City" , 'Chicago' , 'Houston' , 'Los Angeles' , 'Phoenix' , 'Philadelphia' , 'San Antonio'] 
print(my_list)
my_cmb ['values'] = my_list
my_cmb.grid(row=3, column=1,ipadx=10,ipady=4)

#===========================LST_FOR_ERNTRY_SP2==================================
def get_names():
    conn = pymssql.connect(host='localhost', database='MovieRentalsDB')
    my_cursor1 = conn.cursor()
    my_cursor1.execute(f"SELECT DISTINCT Name FROM Customers")
    result = []
    for row in my_cursor1:
        result.append(row)
    conn.close()
    return result

my_lst = get_names()  
print(my_lst)
#===========================SP2==================================
def display_all_orders_by_customers(CustomerName):
    CustomerName
    print (CustomerName)
    newWindow = Toplevel(window)
    newWindow.title("All orders From Customer - " + CustomerName)
    newWindow.geometry("500x500")
    myEntry.delete(0,END)
    conn = pymssql.connect(host='localhost', database='MovieRentalsDB')
    my_cursor2 = conn.cursor()
    my_cursor2.execute(f"execute [spDisplayAllOrdersByCustomer] '{CustomerName}'")

    Label(newWindow, text="Name").grid(column=0,row=0)
    Label(newWindow, text="Amount Of Orders").grid(column=1,row=0)
    for i,my_current_row in enumerate (my_cursor2):
        for j,curr_col in enumerate (my_current_row):
            st2 = f'{curr_col}'
            print (st2)
            Label (newWindow, text=st2).grid(row=i+1,column=j)
    conn.close()

#==========================SP2-BTN+ENTRY===================================
myEntry = Entry(window, font=('Arial',12))
myEntry.grid(row=4,column=1,columnspan=1)

btn1 = Button(window,text="Display Orders by Customer",
        command= lambda: display_all_orders_by_customers(myEntry.get())).grid(row=4, column=0,pady=20,padx=5,ipadx=10,ipady=10)



#===========================SP3==================================
def Display_All_The_Movies_Names_And_Category():
    newWindow = Toplevel(window)
    newWindow.title("All Movies and Categories - ")
    newWindow.geometry("500x500")
    conn = pymssql.connect(host='localhost', database='MovieRentalsDB')
    my_cursor5 = conn.cursor()
    my_cursor5.execute(f"execute [spDisplayAllTheMoviesNamesAndCategory]")
   
    Label(newWindow, text="Movie Name").grid(column=0,row=0)
    Label(newWindow, text="Category").grid(column=1,row=0)
    for i,my_current_row in enumerate (my_cursor5):
        for j,curr_col in enumerate (my_current_row):
            st1 = f'{curr_col}'
            print (st1)
            Label (newWindow, text=st1).grid(row=i+1,column=j)
    conn.close()

#==========================SP3-BTN===================================
btn2 = Button(window, text="Display all movies and category",command=Display_All_The_Movies_Names_And_Category)
btn2.grid(row=6,column=0,columnspan=2,rowspan=2,ipady=30,ipadx=60)


window.mainloop()