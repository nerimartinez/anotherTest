using DataAccess.IRepositories;
using DataAccess.Models;
using DataAccess.Repositories;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace DataAccess
{
    public class TagRepository : BaseRespository, ITagRepository
    { 
        public List<Tag> GetAll()
        {
            conn = new SqlConnection(connString);
            SqlDataReader rdr = null;
            List<Tag> result = new List<Tag>();
            try
            {                
                conn.Open();

                SqlCommand cmd = new SqlCommand("GetAllTags", conn);

                cmd.CommandType = CommandType.StoredProcedure;

                rdr = cmd.ExecuteReader();

                while (rdr.Read())
                {
                    var tag = new Tag();
                    tag.Name = rdr["Name"] == null ? "" : rdr["Name"].ToString();                    
                    tag.Id = int.Parse(rdr["Id"].ToString());                    

                    result.Add(tag);
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

        public int Add(string name)
        {            
            int result = -1;

            try
            {                
                conn.Open();

                SqlCommand cmd = new SqlCommand("AddTag", conn);

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(
                new SqlParameter("@Name", name));

                result = int.Parse (cmd.ExecuteScalar().ToString());                
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

        public void Delete(int id)
        {
            try
            {                
                conn.Open();

                SqlCommand cmd = new SqlCommand("DeleteTag", conn);

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(
                new SqlParameter("@Id", id));
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

        public void Edit(int id, string name)
        {
            try
            {         
                conn.Open();

                SqlCommand cmd = new SqlCommand("EditTag", conn);

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(
                new SqlParameter("@Id", id));
                cmd.Parameters.Add(
                new SqlParameter("@Name", name));

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
