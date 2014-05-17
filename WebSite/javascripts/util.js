
    var prev = document.getElementById('prev');
    var next = document.getElementById('next');
    var metas = document.getElementsByTagName('meta');
    var curr = 1;
    for(var i = 0;i<metas.length;i++)
    {
      if(metas[i].name == 'chapter')
      {
        curr = parseInt(metas[i].content);
      }
    }
    var prevch = curr-1;
    var nextch = curr+1;
    if(curr<=1)
      prev.href = '../index.html';
    else
      prev.href = './Chapter'+(prevch<=9?'0':'') + '' + prevch+ '.html';
    next.href = './Chapter'+(nextch<=9?'0':'')+''+nextch+'.html';
