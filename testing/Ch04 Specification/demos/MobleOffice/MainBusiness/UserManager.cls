VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "UserManager"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Attribute VB_Ext_KEY = "RVB_UniqueId" ,"3DB2E3FC0176"
Attribute VB_Ext_KEY = "RVB_ModelStereotype" ,"Class Module"
'ɾ���û�ʱ������������ɾ����Ҫ�� ID & Name ����������ֶ�����Ϊ null��
'�о��û����������Ʋ�����Ҫ�ж� LogonName �Ƿ�Ϊ�ա�

Option Explicit

'�����û��ʻ���

'##ModelId=3DB2F0170365
Implements IMaintData

'##ModelId=3DB5BD94000B
Private Const ErrClassName = "MainBusiness.UserManager"


'���������ȫ��ͨѶ¼�е��û�
'##ModelId=3DB83DFA02E9
Public Function GetUserInGL() As Recordset
    Const ErrFuncName = "IMaintData_GetAll"
    On Error GoTo ErrHandler

    Dim rs As ADODB.Recordset
    Set rs = CreateObject("ADODB.Recordset")

    rs.ActiveConnection = dbConnString
    rs.Source = "SELECT * FROM Users WHERE LogonName IS NOT NULL AND IsInGL=1 and MobileNumber <> ''"
    rs.LockType = adLockReadOnly
    rs.CursorLocation = adUseClient
    rs.CursorType = adOpenStatic

    rs.Open

    Set rs.ActiveConnection = Nothing
    Set GetUserInGL = rs
    
    Exit Function
ErrHandler:
    ErrorLog ErrClassName, ErrFuncName, Err
    Resume Next
End Function


'���ָ�����ŵ��û��б�
'##ModelId=3DB5543401F4
Private Function IMaintData_GetListByUserID(UserID As Long) As Recordset
    Const ErrFuncName = "IMaintData_GetListByUserID"
    On Error GoTo ErrHandler

    Dim rs As ADODB.Recordset
    Set rs = CreateObject("ADODB.Recordset")

    rs.ActiveConnection = dbConnString
    rs.Source = "SELECT * FROM Users WHERE DeptID=" & UserID
    rs.LockType = adLockBatchOptimistic
    rs.CursorLocation = adUseClient
    rs.CursorType = adOpenStatic

    rs.Open

    Set rs.ActiveConnection = Nothing
    Set IMaintData_GetListByUserID = rs
    
    Exit Function
ErrHandler:
    ErrorLog ErrClassName, ErrFuncName, Err
    Resume Next
End Function

'�õ�һ����¼��
'������
'ID: long
'��ʶ
'##ModelId=3DB3EFF9002B
Private Function IMaintData_GetListByID(UserID As Long) As Recordset
    Const ErrFuncName = "IMaintData_GetListByID"
    On Error GoTo ErrHandler

    Dim rs As ADODB.Recordset
    Set rs = CreateObject("ADODB.Recordset")

    rs.ActiveConnection = dbConnString
    rs.Source = "SELECT * FROM Users WHERE ID=" & UserID
    rs.LockType = adLockBatchOptimistic
    rs.CursorLocation = adUseClient
    rs.CursorType = adOpenStatic

    rs.Open

    Set rs.ActiveConnection = Nothing
    Set IMaintData_GetListByID = rs
    
    Exit Function
ErrHandler:
    ErrorLog ErrClassName, ErrFuncName, Err
    Resume Next
End Function

'�õ��ռ�¼����(���ͻ������)
'##ModelId=3DB3EFF90125
Private Function IMaintData_GetEmpty() As Recordset
    Const ErrFuncName = "IMaintData_GetEmpty"
    On Error GoTo ErrHandler

    Dim rs As ADODB.Recordset
    Set rs = CreateObject("ADODB.Recordset")

    rs.CursorLocation = adUseClient
    rs.CursorType = adOpenStatic
    rs.LockType = adLockBatchOptimistic
    rs.Source = "SELECT * FROM Users WHERE 0=1"
    rs.ActiveConnection = dbConnString
    rs.Open
    rs.AddNew

    Set rs.ActiveConnection = Nothing
    Set IMaintData_GetEmpty = rs

    Exit Function
ErrHandler:
    ErrorLog ErrClassName, ErrFuncName, Err
    Resume Next
End Function

'ɾ��һ����¼����
'������
'ID: long
'��ʶ
'##ModelId=3DB3EFF90193
Private Sub IMaintData_Delete(ID As Long)
    Const ErrFuncName = "IMaintData_Delete"
    On Error GoTo ErrHandler

    Dim conn As ADODB.Connection

    Set conn = CreateObject("ADODB.Connection")
    conn.ConnectionString = dbConnString
    conn.Open
    conn.Execute "UPDATE Users SET LogonName=NULL, Password=NULL, IPAddr=NULL, MobileNumber=NULL, DeptID=NULL, Permission=NULL, IsInGL=NULL, IsUseSysPhrase=NULL, Email=NULL, EmailRulerType=NULL WHERE ID=" & ID
    
    conn.Execute "DELETE FROM Contacts WHERE UserID=" & ID
    conn.Execute "DELETE FROM ContactGroups WHERE UserID=" & ID
    
    conn.Execute "DELETE FROM EmailNotify WHERE UserID=" & ID
    conn.Execute "DELETE FROM EventSubscribe WHERE UserID=" & ID
    conn.Execute "DELETE FROM Schedule WHERE UserID=" & ID
    conn.Execute "DELETE FROM PvtPhrase WHERE UserID=" & ID
    conn.Execute "DELETE FROM MRUMobile WHERE UserID=" & ID
    conn.Close
    Set conn = Nothing

    Exit Sub
ErrHandler:
    ErrorLog ErrClassName, ErrFuncName, Err
    Resume Next
End Sub


'�õ����еļ�¼����
'������
'return: recordset
'�������еļ�¼��
'##ModelId=3DB3EFF902AC
Private Function IMaintData_GetAll() As Recordset
    Const ErrFuncName = "IMaintData_GetAll"
    On Error GoTo ErrHandler

    Dim rs As ADODB.Recordset
    Set rs = CreateObject("ADODB.Recordset")

    rs.ActiveConnection = dbConnString
    rs.Source = "SELECT * FROM Users WHERE LogonName IS NOT NULL AND Permission<>8"
    rs.LockType = adLockReadOnly
    rs.CursorLocation = adUseClient
    rs.CursorType = adOpenStatic

    rs.Open

    Set rs.ActiveConnection = Nothing
    Set IMaintData_GetAll = rs
    
    Exit Function
ErrHandler:
    ErrorLog ErrClassName, ErrFuncName, Err
    Resume Next
End Function


'����һ����¼����
'������
'ID: long
'��ʶ
'##ModelId=3DB3F1680099
Private Sub IMaintData_Save(rs As Recordset)
    Const ErrFuncName = "IMaintData_Save"
    On Error GoTo ErrHandler
    
    rs.ActiveConnection = dbConnString
    rs.UpdateBatch
    
    Exit Sub
ErrHandler:
    ErrorLog ErrClassName, ErrFuncName, Err
    Resume Next
End Sub


'�õ� Exchange Server �е������ʼ�
Public Function GetExgEmails() As ADODB.Recordset
    Const ErrFuncName = "GetExgEmails"
    On Error GoTo ErrHandler
    
    Dim rs As ADODB.Recordset
    Set rs = CreateObject("ADODB.Recordset")

    rs.ActiveConnection = dbConnString
    rs.Source = "SELECT Email FROM MailList"
    rs.LockType = adLockReadOnly
    rs.CursorLocation = adUseClient
    rs.CursorType = adOpenStatic

    rs.Open

    Set rs.ActiveConnection = Nothing
    Set IMaintData_GetAll = rs
    
    Exit Function
ErrHandler:
    ErrorLog ErrClassName, ErrFuncName, Err
    Resume Next
End Function