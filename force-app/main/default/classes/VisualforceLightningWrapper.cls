public with sharing class VisualforceLightningWrapper {

    // エラーメッセージ
    public String errorMessage {get; set;}
    // 取引先名
    public String accountName {get; set;}
    // 取引先番号
    public String accountNumber {get; set;}
    // 取得上限
    public Integer searchLimit {get; set;}
    // 取引先リスト
    public List<Account> accounts {get; set;}

    /**
     * コンストラクタ
     */
    public VisualforceLightningWrapper() {
        // エラーメッセージ
        this.errorMessage = '';
        // 取引先名
        this.accountName = '';
        // 取引先番号
        this.accountNumber = '';
        // 取得上限
        this.searchLimit = 1000;
        // 取引先リスト
        this.accounts = new List<Account>();
    }
}