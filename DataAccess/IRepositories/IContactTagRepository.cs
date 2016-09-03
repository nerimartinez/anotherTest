using DataAccess.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.IRepositories
{
    public interface IContactTagRepository
    {
        /// <summary>
        /// Adds a tag to a user
        /// </summary>
        /// <param name="contactId"></param>
        /// <param name="tagId"></param>
        /// <returns></returns>
        int Add(int contactId, int tagId);

        /// <summary>
        /// Deletes a tag from a user
        /// </summary>
        /// <param name="contactId"></param>
        /// <param name="tagId"></param>
        void Delete(int contactId, int tagId);
    }
}
