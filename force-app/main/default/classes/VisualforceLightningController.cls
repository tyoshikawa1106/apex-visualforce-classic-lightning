public with sharing class VisualforceLightningController {

    /**
     * コンストラクタ
     */
    public VisualforceLightningController() {

    }

    /**
     * 初期処理
     */
    @RemoteAction
    public static VisualforceLightningWrapper init() {
        return new VisualforceLightningWrapper();
    }

    /**
     * 取引先検索
     */
    @RemoteAction
    public static VisualforceLightningWrapper getAccounts(VisualforceLightningWrapper wrapper) {
        try {
            // 取引先検索
            wrapper.accounts = VisualforceLightningController.getAccountQueryResult(wrapper);
        } catch(Exception e) {
            wrapper.errorMessage = e.getMessage();
            return wrapper;
        }

        return wrapper;
    }

    /**
     * 取引先取得
     */
    private static List<Account> getAccountQueryResult(VisualforceLightningWrapper wrapper) {

        Integer queryLimit = (wrapper.searchLimit != null && wrapper.searchLimit > 0) ? wrapper.searchLimit : 1;

        String query = '';
        query += ' SELECT ';
        query += '  Id ';
        query += ' ,Name ';
        query += ' ,AccountNumber ';
        query += ' FROM ';
        query += ' Account ';
        String joinQuery = ' WHERE ';
        // 取引先名判定
        if (String.isNotEmpty(wrapper.accountName)) {
            query += joinQuery + ' Name = ' + '\'' + String.escapeSingleQuotes(wrapper.accountName) + '\'';
            joinQuery = ' AND ';
        }
        // 取引先番号判定
        if (String.isNotEmpty(wrapper.accountNumber)) {
            query += joinQuery + ' AccountNumber = ' + '\'' + String.escapeSingleQuotes(wrapper.accountNumber) + '\'';
            joinQuery = ' AND ';
        }
        query += ' ORDER BY Name ASC ';
        query += ' LIMIT ' + String.valueOf(queryLimit);
        // クエリ実行
        return Database.query(query);
    }
}