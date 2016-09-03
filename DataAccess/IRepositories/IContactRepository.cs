using DataAccess.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.IRepositories
{
    public interface IContactRepository
    {
        /// <summary>
        /// Returns a list of contacts with their tag ids
        /// </summary>
        /// <returns></returns>
        List<Contact> GetContactsWithTagIds();
    }
}
