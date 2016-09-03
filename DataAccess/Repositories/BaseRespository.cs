using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.Repositories
{
    public class BaseRespository
    {
        protected string connString = ConfigurationManager.ConnectionStrings["AvnonConnectionString"].ToString();
        protected SqlConnection conn = null;

        public BaseRespository()
        {
            conn = new SqlConnection(connString);
        }
    }
}
