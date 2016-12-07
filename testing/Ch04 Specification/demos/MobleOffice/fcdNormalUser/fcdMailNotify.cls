VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "fcdMailNotify"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Attribute VB_Ext_KEY = "RVB_UniqueId" ,"3DABFBFC02F9"
Attribute VB_Ext_KEY = "RVB_ModelStereotype" ,"Class Module"
'�ʼ�����֪ͨ������

Option Explicit


'�õ�ָ�� ID ���ʼ����˹���
'##ModelId=3DB45DE3016F
Public Function GetRulerByID(ID As Long) As Recordset
    Dim objMngr As MainBusInterface.IMaintData
    Set objMngr = CreateObject("MainBusiness.MailNotifyManager")
    Set GetRulerByID = objMngr.GetListByID(ID)
    Set objMngr = Nothing
    
End Function


'�õ��û����ʼ����˹����б���
'������
'UserID: long
'�û��ı�ʶ
'return: recordset
'�ʼ�����ļ�¼��
'##ModelId=3DAFE880018A
Public Function GetRulerList(UserID As Long) As Recordset
    Dim objMngr As MainBusInterface.IMaintData
    Set objMngr = CreateObject("MainBusiness.MailNotifyManager")
    Set GetRulerList = objMngr.GetListByUserID(UserID)
    Set objMngr = Nothing
    
End Function


'ɾ��ָ�� ID �ʼ�����
'������
'ID: long
'�ʼ�����ı�ʶ
'##ModelId=3DAFE95102DA
Public Sub DeleteRuler(ID As Long)
    Dim objMngr As MainBusInterface.IMaintData
    Set objMngr = CreateObject("MainBusiness.MailNotifyManager")
    objMngr.Delete ID
    Set objMngr = Nothing
    
End Sub


'�õ�һ���ռ�¼����
'������
'Return: Recordset
'����һ���ռ�¼��
'##ModelId=3DAFE9D60262
Public Function GetEmptyRecordset() As Recordset
    Dim objMngr As MainBusInterface.IMaintData
    Set objMngr = CreateObject("MainBusiness.MailNotifyManager")
    Set GetEmptyRecordset = objMngr.GetEmpty()
    Set objMngr = Nothing
    
End Function


'�����ʼ����˹���
'������
'rs: recordset
'�����ʼ����˹���ļ�¼��
'##ModelId=3DAFEA0D0032
Public Sub SaveRulers(rs As Recordset)
    Dim objMngr As MainBusInterface.IMaintData
    Set objMngr = CreateObject("MainBusiness.MailNotifyManager")
    objMngr.Save rs
    Set objMngr = Nothing
    
End Sub


'�����û��ʻ�����Ϣ��(�����û���Ϣ���е��ʼ�����������Ϣ)
'������
'rs: recordset
'�û��ʻ�����Ϣ��¼��
'##ModelId=3DAFEA7C0278
Public Sub SaveUserInfo(rs As Recordset)
    Dim objMngr As MainBusInterface.IMaintData
    Set objMngr = CreateObject("MainBusiness.UserManager")
    objMngr.Save rs
    Set objMngr = Nothing
    
End Sub