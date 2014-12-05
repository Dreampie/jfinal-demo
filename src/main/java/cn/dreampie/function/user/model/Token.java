package cn.dreampie.function.user.model;

import cn.dreampie.tablebind.TableBind;
import cn.dreampie.web.model.Model;

import java.util.UUID;


/**
 * Created by wangrenhui on 14-4-17.
 */
@TableBind(tableName = "sec_token", pkName = "uuid")
public class Token extends Model<Token> {
  public static Token dao = new Token();

  public boolean save() {
    this.set("uuid", UUID.randomUUID());
    return super.save();
  }

}