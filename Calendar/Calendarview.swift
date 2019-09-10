
import Foundation
import UIKit

class Calendarview : UIView , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    var collectionview : UICollectionView!
    var colorForLabel : UIColor = .gray
    var weekLabelView : UIView!
    var showYearMonthLabel : UILabel!
    var lastButton : UIButton!
    var nextButton : UIButton!
    var date = Date()
    var currentYear : Int!
    var currentMonth : Int!
    var currentDay : Int!
    override func didAddSubview(_ subview: UIView) {
        
    }
    override func didMoveToSuperview() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

        collectionview = UICollectionView(frame: CGRect(x: 0, y: (self.bounds.height) / 7, width: self.bounds.width, height: self.bounds.height - (self.bounds.height) / 7) , collectionViewLayout: layout)
        collectionview.register(CalendarCell.self, forCellWithReuseIdentifier: "Cell")
        collectionview.dataSource = self
        collectionview.delegate = self
        self.addSubview(collectionview!)
        setWeekLabel()
        setMonthButton()
        setYearMonthLabel()
        currentMonth = setCurrentMonth(date: date)
        currentYear = setCurrentYear(date: date)
        currentDay = setCurrentDay(date: date)
        setshowYearMonthLabel(currentYear : currentYear , currentMonth : currentMonth)
        collectionview.reloadData()
        
    }
    func setshowYearMonthLabel(currentYear : Int , currentMonth : Int){
        showYearMonthLabel.text = "\(currentYear)-\(currentMonth)"
    }
    func setCurrentMonth(date:Date) -> Int{
        let currentMonth = Calendar.current.component(.month, from: Date())
        return currentMonth
    }
    func setCurrentYear(date:Date) -> Int{
        let currentYear = Calendar.current.component(.year, from: Date())
        return currentYear
    }
    func setCurrentDay(date: Date) -> Int{
        let currentDay = Calendar.current.component(.day, from: Date())
        return currentDay
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 42
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.bounds.width / 7, height: (self.bounds.height) / 7)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CalendarCell
        cell.lbshow = UILabel(frame: CGRect(x: 3, y: 3, width: cell.frame.width - 6, height: cell.frame.height - 6))
        cell.lbshow.backgroundColor = colorForLabel
        
        cell.lbshow.textAlignment = .center
        
        cell.lbshow.text = String(indexPath.row)
        if indexPath.row < whatDayIsIt() - 1 || indexPath.row > numberOfDaysInThisMonth() + whatDayIsIt() - 2{
            cell.lbshow.text = ""
        }else{
            cell.lbshow.text = "\(indexPath.row - whatDayIsIt() + 2)"
        }
        if currentYear == Calendar.current.component(.year, from: Date()) && currentMonth == Calendar.current.component(.month, from: Date()){
            if indexPath.row < whatDayIsIt() - 1 || indexPath.row > currentDay + whatDayIsIt() - 2{
                cell.lbshow.textColor = .white
            }else{
                cell.lbshow.textColor = .black
            }
        }
        cell.addSubview(cell.lbshow)
        cell.backgroundColor = .blue
        return cell
    }
    func numberOfDaysInThisMonth() ->Int{
        let dateComponents = DateComponents(year: currentYear , month: currentMonth )
        let date = Calendar.current.date(from: dateComponents)!
        let range = Calendar.current.range(of: .day, in: .month,for: date)
        return range?.count ?? 0
    }
    func whatDayIsIt() ->Int{
        let dateComponents = DateComponents(year: currentYear , month: currentMonth)
        let date = Calendar.current.date(from: dateComponents)!
        return Calendar.current.component(.weekday, from: date)
    }
    func setWeekLabel(){
        for i in 0...6 {
            let weight = self.bounds.width / 7
            weekLabelView = UIView(frame: CGRect(x: 0 + weight * CGFloat(i), y: (self.bounds.height) / 14, width: self.bounds.width / 7, height: (self.bounds.height) / 14))
            let label = UILabel (frame: CGRect(x: 3, y: 3, width: weekLabelView.frame.width - 6, height: weekLabelView.frame.height - 6))
            label.text = "\(i+1)"
            label.textAlignment = .center
            weekLabelView.addSubview(label)
            self.addSubview(weekLabelView)
        }
    }
    func setMonthButton(){
        lastButton = UIButton(frame: CGRect(x: 0, y: 0, width: self.frame.width / 7, height: self.frame.height / 14))
        nextButton = UIButton(frame: CGRect(x: self.frame.width - self.frame.width / 7, y: 0, width: self.frame.width / 7, height: self.frame.height / 14))
        lastButton.titleLabel?.font = UIFont(name: (lastButton.titleLabel?.font.fontName)!, size: self.frame.height / 14)
        lastButton.setTitle("\u{25C0}", for: .normal)
        lastButton.setTitleColor(.white, for: .normal)
        lastButton.backgroundColor = .black
        lastButton.tag = 0
        lastButton.addTarget(self, action: #selector(click(_:)), for: .touchUpInside)
        nextButton.titleLabel?.font = UIFont(name: (lastButton.titleLabel?.font.fontName)!, size: self.frame.height / 14)
        nextButton.setTitle("\u{25B6}", for: .normal)
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.backgroundColor = .black
        nextButton.tag = 1
        nextButton.addTarget(self, action: #selector(click(_:)), for: .touchUpInside)
        self.addSubview(lastButton)
        self.addSubview(nextButton)
    }
    
    func setYearMonthLabel(){
        showYearMonthLabel = UILabel(frame: CGRect(x: self.frame.width / 7, y: 0, width: self.frame.width - self.frame.width / 7 * 2, height: self.frame.height / 14))
        showYearMonthLabel.textAlignment = .center
        showYearMonthLabel.backgroundColor = colorForLabel
        showYearMonthLabel.textColor = .black
        self.addSubview(showYearMonthLabel)
        
    }
    @objc func click(_ sender: UIButton){
        if sender.tag == 0 {
            currentMonth -= 1
            if currentMonth == 0 {
                currentMonth = 12
                currentYear -= 1
            }
            setshowYearMonthLabel(currentYear : currentYear , currentMonth : currentMonth)
            collectionview.reloadData()
        }else{
            if currentMonth < Calendar.current.component(.month, from: Date()) || currentYear != Calendar.current.component(.year, from: Date()) {
                currentMonth += 1
                if currentMonth == 13 {
                    currentMonth = 1
                    currentYear += 1
                }
                setshowYearMonthLabel(currentYear : currentYear , currentMonth : currentMonth)
                collectionview.reloadData()
            }
        }
    }
    class CalendarCell: UICollectionViewCell {
        var lbshow : UILabel!
    }
    
}
