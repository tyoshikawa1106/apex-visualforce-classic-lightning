public with sharing class VisualforceClassicController {

    // 取引先リスト
    public List<Account> accounts {get; set;}
    // 検索条件
    public Account account {get; set;}
    // 取得件数上限
    public Integer searchLimit {get; set;}

    /**
     * コンストラクタ
     */
    public VisualforceClassicController() {
        // 取引先リスト
        this.accounts = new List<Account>();
        // 検索キー
        this.account = new Account();
        // 取得件数上限
        this.searchLimit = 1000;
    }

    /**
     * 取引先検索
     */
    public void doSearch() {
        this.accounts = this.getAccounts(this.account, this.searchLimit);
    }
    
    /**
     * クリア
     */
    public void doClear() {
        this.accounts = new List<Account>();
    }

    /**
     * 取引先取得
     */
    private List<Account> getAccounts(Account prmAccount, Integer prmSearchLimit) {

        Integer queryLimit = (prmSearchLimit != null && prmSearchLimit > 0) ? prmSearchLimit : 1;

        String query = '';
        query += ' SELECT ';
        query += '  Id ';
        query += ' ,Name ';
        query += ' ,AccountNumber ';
        query += ' FROM ';
        query += ' Account ';
        String joinQuery = ' WHERE ';
        // 取引先名判定
        if (String.isNotEmpty(prmAccount.Name)) {
            query += joinQuery + ' Name = ' + '\'' + String.escapeSingleQuotes(prmAccount.Name) + '\'';
            joinQuery = ' AND ';
        }
        // 取引先番号判定
        if (String.isNotEmpty(prmAccount.AccountNumber)) {
            query += joinQuery + ' AccountNumber = ' + '\'' + String.escapeSingleQuotes(prmAccount.AccountNumber) + '\'';
            joinQuery = ' AND ';
        }
        query += ' ORDER BY Name ASC ';
        query += ' LIMIT ' + String.valueOf(queryLimit);
        // クエリ実行
        return Database.query(query);
    }
}