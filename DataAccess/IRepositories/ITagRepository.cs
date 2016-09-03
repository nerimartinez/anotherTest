using DataAccess.Models;
using System.Collections.Generic;

namespace DataAccess.IRepositories
{
    public interface ITagRepository
    {
        /// <summary>
        /// Gets all the tags
        /// </summary>
        /// <returns></returns>
        List<Tag> GetAll();

        /// <summary>
        /// Adds a tag
        /// </summary>
        /// <param name="name"></param>
        /// <returns>Tag id</returns>
        int Add(string name);

        /// <summary>
        /// Deletes a tag
        /// </summary>
        /// <param name="id"></param>
        void Delete(int id);

        /// <summary>
        /// Edits a tag
        /// </summary>
        /// <param name="id"></param>
        /// <param name="name"></param>
        void Edit(int id, string name);
    }
}
