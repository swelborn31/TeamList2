using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using TeamList.Class_Code;

namespace TeamList
{
    public partial class _Default : Page
    {
        private static List<TeamMembers> MasterTeamMembers = new List<TeamMembers>();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                this.BindTeamMembers();
            }
        }
        /* Clear controls values and Set default value to controls */
        private void ClearControls()
        {
            
            hfAddEdit.Value = "ADD";
            btnSave.Text = "ADD";
            lblHeading.Text = "Add Team Details";
            hfAddEditTeamMemberId.Value = "0";
            hfDeleteTeamMemberId.Value = "0";
            
            txtFName.Text = string.Empty;
            txtLName.Text = string.Empty;
            txtPosition.Text = string.Empty;
        }
        /* Bind TeamMember Grid*/
        private void BindTeamMembers()
        {
            if(MasterTeamMembers.Count() == 0) { 
            //Initial Population
            List<TeamMembers> TeamMembers = new List<TeamMembers> {
                    new TeamMembers {ID=1, FName="Team member1 FirstName1",LName="Team Member3 Last Name1",Position="striker"},
                    new TeamMembers {ID=2, FName="Team member2 FirstName2",LName="Team Member2 Last Name2",Position="Forward"},
                    new TeamMembers {ID=3, FName="Team member3 FirstName3",LName="Team Member3 Last Name3",Position="Goalie"},
                };
                MasterTeamMembers = TeamMembers;
            }
            GridView1.DataSource = MasterTeamMembers;
            GridView1.DataBind();

        }
        /* Edit TeamMember Detail*/
        protected void Edit(object sender, EventArgs e)
        {
            /* Change label text of lblHeading on Edit button Click */
            lblHeading.Text = "Update Team Member Details";

            /* Sets CommandArgument value to hidden field hfAddEditTeamMemberId */
            hfAddEditTeamMemberId.Value = (sender as Button).CommandArgument;

            /* Sets value from Grid cell to textboxes txtName,txtCountry and txtSalary */
            txtFName.Text = ((sender as Button).NamingContainer as GridViewRow).Cells[1].Text;
            txtLName.Text = ((sender as Button).NamingContainer as GridViewRow).Cells[2].Text;
            txtPosition.Text = ((sender as Button).NamingContainer as GridViewRow).Cells[3].Text;

            /* Change text of button as Update*/
            btnSave.Text = "Update";

            

            /* Show AddUpdateTeamMember Modal Popup */
            mpeAddUpdateTeamMember.Show();
        }

        /*Add TeamMember Detail*/
        protected void Add(object sender, EventArgs e)
        {
            /* Clear Controls Value */
            ClearControls();

          

            /* Show mpeAddUpdateTeamMember Modal Popup */
            mpeAddUpdateTeamMember.Show();
        }
        /* Save or Update TeamMember Details*/
        protected void Save(object sender, EventArgs e)
        {
            //Chck to see if fields are entered.
            if (Page.IsValid)
            {
                BindTeamMembers();
               
                int TeamMemberId = Convert.ToInt32(hfAddEditTeamMemberId.Value);

                if (TeamMemberId > 0)
                {
                    //Update
                    var itemIndex = MasterTeamMembers.FindIndex(x => x.ID == TeamMemberId);
                    var item = MasterTeamMembers.ElementAt(itemIndex);
                    item.FName = txtFName.Text.Trim();
                    item.LName = txtLName.Text.Trim();
                    item.Position = txtPosition.Text.Trim();
                }
                else
                {
                    //Add
                    TeamMembers locTeamMembers = new TeamMembers();
                    locTeamMembers.ID = MasterTeamMembers.Count() + 1;
                    locTeamMembers.FName = txtFName.Text.Trim();
                    locTeamMembers.LName = txtLName.Text.Trim();
                    locTeamMembers.Position = txtPosition.Text.Trim();

                    MasterTeamMembers.Add(locTeamMembers);
                }



                /* Bind TeamMember Grid*/
                BindTeamMembers();

                /* Hide mpeAddUpdateTeamMember Modal Popup */
                mpeAddUpdateTeamMember.Hide();

                /* Clear Controls Value */
                ClearControls();
            }
        }

        /* Delete Emploee Detail*/
        protected void Delete(object sender, EventArgs e)
        {
            /* Apply CommandArgument value to hidden field hfDeleteTeamMemberId */
            hfDeleteTeamMemberId.Value = (sender as Button).CommandArgument;


            /* Show DeleteTeamMember Modal Popup */
            mpeDeleteTeamMember.Show();
        }

        /* If Select Yes on Delete Modal Popup */
        protected void Yes(object sender, EventArgs e)
        {
            /* Code to Delete TeamMember Record */
           
            int TeamMemberId = Convert.ToInt32(hfDeleteTeamMemberId.Value);

            MasterTeamMembers.RemoveAll(s => s.ID == TeamMemberId);
            /* Bind Grid Again To see latest Records*/
            BindTeamMembers();

            /* Hide Delete TeamMember Modal Popup */
            mpeDeleteTeamMember.Hide();

            /*Clear Controls Value*/
            ClearControls();
        }

    }

}