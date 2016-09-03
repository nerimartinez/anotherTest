using DataAccess.IRepositories;
using DataAccess.Models;
using DataAccess.Repositories;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace DataAccess
{
    public class ContactRepository : BaseRespository, IContactRepository
    {
        public List<Contact> GetContactsWithTagIds()
        {            
            SqlDataReader rdr = null;
            List<Contact> result = new List<Contact>();
            
            try
            {   
                conn.Open();
                
                SqlCommand cmd = new SqlCommand("GetContactsWithTagIds", conn);
                                
                cmd.CommandType = CommandType.StoredProcedure;
                             
                rdr = cmd.ExecuteReader();
                
                while (rdr.Read())
                {
                    var contact = new Contact();
                    contact.CompanyName = rdr["CompanyName"] == null? "" : rdr["CompanyName"].ToString();
                    contact.Email = rdr["CompanyName"] == null ? "" : rdr["Email"].ToString();
                    contact.FirstName = rdr["CompanyName"] == null ? "" : rdr["FirstName"].ToString();
                    contact.LastName = rdr["CompanyName"] == null ? "" : rdr["LastName"].ToString();
                    contact.Phone = rdr["CompanyName"] == null ? "" : rdr["Phone"].ToString();
                    contact.Position = rdr["CompanyName"] == null ? "" : rdr["Position"].ToString();
                    contact.Skype = rdr["CompanyName"] == null ? "" : rdr["Skype"].ToString();
                    contact.Id = int.Parse(rdr["Id"].ToString());
                    if (rdr["TagIds"].ToString() != String.Empty)
                        contact.TagIds = Regex.Split(rdr["TagIds"].ToString(), ", ").Select(Int32.Parse).ToList();
                    else
                        contact.TagIds = new List<int>();

                    result.Add(contact);
                }
            }
            finally
            {
                if (conn != null)
                {
                    conn.Close();
                }
                if (rdr != null)
                {
                    rdr.Close();
                }
            }
            return result;
        }
    }
}
