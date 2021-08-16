import { Component, Input, OnInit, Output } from '@angular/core';
import { Verification } from 'src/app/models/verification.model';

@Component({
  selector: 'app-ide-sql',
  templateUrl: './ide-sql.component.html',
  styleUrls: ['./ide-sql.component.scss']
})
export class IdeSqlComponent implements OnInit {
  @Input()  width:string              = '800px';
  @Input()  height:string             = '550px';
  @Input()  editing:Verification      = {};

  currentKey:string = '';
  keywords:string[] = [
    'CREATE','PRIMARY KEY','INSERT','SELECT','FROM','ALTER','ADD','DISTINCT','UPDATE','SET','DELETE','TRUNCATE','AS','ORDER BY','ASC','DESC','BETWEEN','WHERE','AND','OR','NOT','LIMIT','IS NULL','DROP','DROP COLUMN','DROP DATABASE','DROP TABLE','GROUP BY','HAVING','IN','JOIN','UNION','UNION ALL','EXISTS','LIKE','CASE'
  ]
  constructor() { }

  ngOnInit(): void {
  }

  setCurrentWord(key:any){
    setTimeout(() => console.log(this.editing.query_sql), 0);
  }

  setVerificationSQL(){
    this.editing.query_sql = this.editing.query_sql
  }
}
