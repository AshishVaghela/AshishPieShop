using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace AshishPieShop.Models
{
    public class CategoryRepository : ICategoryRepository
    {
        public readonly AppDbContext _appDbContext;
        public CategoryRepository(AppDbContext appDbContext)
        {
            _appDbContext = appDbContext;
        }

        public IEnumerable<Category> AllCategories => _appDbContext.Categories;
    }
}
