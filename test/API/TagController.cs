using DataAccess;
using DataAccess.IRepositories;
using DataAccess.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace testAvnon.API
{
    public class TagController : ApiController
    {        
        private ITagRepository _tagRepository;

        public TagController(TagRepository tagRepository)
        {            
            _tagRepository = tagRepository;
        }

        public List<Tag> GetAll()
        {
            return _tagRepository.GetAll();
        }
        
        public void Put([FromBody]Tag tag)
        {
            _tagRepository.Edit(tag.Id, tag.Name);
        }
        
        public int Post([FromBody]string name)
        {
            return _tagRepository.Add(name); ;
        }
        
        public void Delete(int id)
        {
            _tagRepository.Delete(id); 
        }
    }
}
