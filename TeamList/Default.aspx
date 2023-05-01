<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="TeamList._Default" %>
 
<!<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="uc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        body
        {
            font-family: Arial;
            font-size: 10pt;
        }
         
        /*CSS Classes For Design Modal*/
        .modalPopup
        {
            min-height: 75px;
            position: fixed;
            z-index: 2000;
            padding: 0;
            background-color: #fff;
            border-radius: 6px;
            background-clip: padding-box;
            border: 1px solid rgba(0, 0, 0, 0.2);
            min-width: 290px;
            box-shadow: 0 5px 10px rgba(0, 0, 0, 0);
        }
        .modalBackground
        {
            position: fixed;
            top: 0;
            left: 0;
            background-color: #000;
            opacity: 0.5;
            z-index: 1800;
            min-height: 100%;
            width: 100%;
            overflow: hidden;
            display: inline-block;
            z-index: 1000;
        }
    </style>
    <%-- Used links for References --%>
    <script type="text/javascript">
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <%--Grid With Add New Temmembers button Design --%>
    <div align="center" style="padding-top: 20px;">
        <div class="row">
            <div class="col-md-12">
                <div class="form-group">
                    <div class="row">
                        <div class="col-md-12">
                            <asp:GridView ID="GridView1" runat="server" CssClass="footable" AutoGenerateColumns="false"
                                Style="max-width: 500px">
                                <Columns>
                                    <asp:BoundField DataField="ID" HeaderText="ID" />
                                    <asp:BoundField DataField="FName" HeaderText="FirstName" />
                                    <asp:BoundField DataField="LName" HeaderText="Last Name" />
                                    <asp:BoundField DataField="Position" HeaderText="Position" DataFormatString="{0:N}" />
                                    <asp:TemplateField HeaderText="">
                                        <ItemTemplate>
                                            <asp:Button ID="btnEdit" runat="server" Text="Edit" OnClick="Edit" CommandArgument='<%# Eval("Id") %>'
                                                class="btn btn-primary" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="">
                                        <ItemTemplate>
                                            <asp:Button ID="btnDelete" runat="server" Text="Delete" OnClick="Delete" CommandArgument='<%# Eval("Id") %>'
                                                class="btn btn-danger" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <EmptyDataTemplate>
                                    <table cellpadding="0" cellspacing="0" width="100%" class="footable">
                                        <tr style="background-color: #DCE9F9;">
                                            <th class="hidden-xs">
                                                <b>ID</b>
                                            </th>
                                            <th>
                                                <b>FName</b>
                                            </th>
                                             <th>
                                                <b>LName</b>
                                            </th>
                                            <th class="hidden-xs">
                                                <b>Position</b>
                                            </th>
                                            
                                            <th>
                                                &nbsp;
                                            </th>
                                            <th>
                                                &nbsp;
                                            </th>
                                        </tr>
                                        <tr>
                                            <td colspan="6" align="center" style="text-align: center;">
                                                <b>No Records Found</b>
                                            </td>
                                        </tr>
                                    </table>
                                </EmptyDataTemplate>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="row">
                        <div class="col-md-12">
                            <asp:Button ID="btnAdd" runat="server" Text="Add New Team Member" OnClick="Add" class="btn btn-success" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
 
    <%--lnkTeamMember Link Button for mpeAddUpdateTeamMember ModalPopup as TargetControlID--%>
    <asp:LinkButton ID="lnkTeamMember" runat="server"></asp:LinkButton>
 
    <%--pnlAddUpdateTeamMemberDetails Panel With Design--%>
    <asp:Panel ID="pnlAddUpdateTeamMemberDetails" runat="server" CssClass="modalPopup"
        Style="display: none;">
        <div style="overflow-y: auto; overflow-x: hidden; max-height: 450px;">
            <div class="modal-header">
                <asp:Label ID="lblHeading" runat="server" CssClass="modal-title"></asp:Label>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <div class="row">
                        <div class="col-md-3">
                            <label for="txtFName">
                                First Name</label>
                        </div>
                        <div class="col-md-6">
                            <asp:TextBox ID="txtFName" runat="server" CssClass="form-control" ValidationGroup="TeamMember" 
                                Width="150px"></asp:TextBox>
                        </div>
                        <div class="col-md-3">
                            <asp:RequiredFieldValidator ID="rfvFName" Display="Dynamic" ValidationGroup="TeamMember"
                                ErrorMessage="Required" ControlToValidate="txtFName" runat="server" ForeColor="Red" />
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="row">
                        <div class="col-md-3">
                            <label for="txtLName">
                                Last Name</label>
                        </div>
                        <div class="col-md-6">
                            <asp:TextBox ID="txtLName" runat="server" CssClass="form-control" ValidationGroup="TeamMember" 
                                Width="150px"></asp:TextBox>
                        </div>
                        <div class="col-md-3">
                            <asp:RequiredFieldValidator ID="rfvLName" ErrorMessage="Required" Display="Dynamic"
                                ValidationGroup="TeamMember" ControlToValidate="txtLName" runat="server" ForeColor="Red" />
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="row">
                        <div class="col-md-3">
                            <label for="txtPosition">
                                Position</label>
                        </div>
                        <div class="col-md-6">
                            <asp:TextBox ID="txtPosition" runat="server" CssClass="form-control" ValidationGroup="TeamMember" 
                                Width="150px"></asp:TextBox>
                        </div>
                        <div class="col-md-3">
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ErrorMessage="Required" Display="Dynamic"
                                ValidationGroup="TeamMember" ControlToValidate="txtPosition" runat="server" ForeColor="Red" />
                        </div>
                    </div>
                </div>
                
            </div>
            <div align="center" class="modal-footer">
                <div class="row">
                    <div class="col-md-12">
                        <asp:HiddenField ID="hfAddEditTeamMemberId" runat="server" Value="0" />
                        <asp:HiddenField ID="hfAddEdit" runat="server" Value="ADD" />
                        <asp:Button ID="btnSave" runat="server" Text="ADD" OnClick="Save" class="btn btn-success"
                            ValidationGroup="TeamMember"></asp:Button>
                        <button id="btnCancel" runat="server" class="btn btn-primary">
                            Cancel
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </asp:Panel>
 
     <%--mpeAddUpdateTeamMember Modal Popup Extender For pnlAddUpdateTeamMemberDetails--%>
    <uc:ModalPopupExtender ID="mpeAddUpdateTeamMember" runat="server" PopupControlID="pnlAddUpdateTeamMemberDetails"
        TargetControlID="lnkTeamMember" BehaviorID="mpeAddUpdateTeamMember" CancelControlID="btnCancel"
        BackgroundCssClass="modalBackground">
    </uc:ModalPopupExtender>
 
    <%--lnkTeamMember1 Link Button for mpeDeleteTeamMember ModalPopup as TargetControlID--%>
    <asp:LinkButton ID="lnkTeamMember1" runat="server"></asp:LinkButton>
 
    <%--pnlDeleteTeamMember Panel With Design--%>
    <asp:Panel ID="pnlDeleteTeamMember" runat="server" CssClass="modalPopup" Style="display: none;">
        <div id="Div1" runat="server" class="header">
        </div>
        <div style="overflow-y: auto; overflow-x: hidden; max-height: 450px;">
            <div class="form-group modal-body">
                <div class="row">
                    <div class="col-md-12">
                        Do you Want to delete this record ?
                    </div>
                </div>
            </div>
        </div>
        <div align="right" class="modal-footer">
            <div class="row">
                <div class="col-md-12">
                    <asp:HiddenField ID="hfDeleteTeamMemberId" runat="server" Value="0" />
                    <asp:Button ID="btnYes" runat="server" Text="Yes" OnClick="Yes" class="btn btn-danger">
                    </asp:Button>
                    <button id="btnNo" runat="server" class="btn btn-default">
                        Cancel
                    </button>
                </div>
            </div>
        </div>
    </asp:Panel>
 
   <%-- mpeDeleteTeamMember Modal Popup Extender For pnlDeleteTeamMember--%>
    <uc:ModalPopupExtender ID="mpeDeleteTeamMember" runat="server" PopupControlID="pnlDeleteTeamMember"
        TargetControlID="lnkTeamMember1" BehaviorID="mpeDeleteTeamMember" CancelControlID="btnNo"
        BackgroundCssClass="modalBackground">
    </uc:ModalPopupExtender>
    </form>
</body>
</html>