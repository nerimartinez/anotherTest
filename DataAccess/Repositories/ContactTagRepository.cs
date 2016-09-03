using DataAccess.IRepositories;
using DataAccess.Repositories;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess
{
    public class ContactTagRepository : BaseRespository, IContactTagRepository
    {
        public int Add(int contactId, int tagId)
        {            
            int result = -1;

            try
            {                
                conn.Open();

                SqlCommand cmd = new SqlCommand("AddContactTag", conn);

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(
                new SqlParameter("@ContactId", contactId));
                cmd.Parameters.Add(
                new SqlParameter("@TagId", tagId));

                cmd.ExecuteNonQuery();
            }
            finally
            {
                if (conn != null)
                {
                    conn.Close();
                }
            }
            return result;
        }

        public void Delete(int contactId, int tagId)
        {         
            try
            {                
                conn.Open();

                SqlCommand cmd = new SqlCommand("DeleteContactTag", conn);

                cmd.CommandType = CommandType.StoredProcedure;                
                cmd.Parameters.Add(
                new SqlParameter("@ContactId", contactId));
                cmd.Parameters.Add(
                new SqlParameter("@TagId", tagId));
                cmd.ExecuteNonQuery();
            }
            finally
            {
                if (conn != null)
                {
                    conn.Close();
                }
            }
        }
    }
}
